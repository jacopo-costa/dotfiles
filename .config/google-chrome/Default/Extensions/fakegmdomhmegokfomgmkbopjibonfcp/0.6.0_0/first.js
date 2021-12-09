//
// The first script to be run on every page as to capture media elements
// when they're created.
//
// Has to be run before anything else is executed in the document.
// Declaring the script in the manifest, as opposed to using
// chrome.tabs.executeScript, seems to be the only way to achieve this from
// my own testing.
// https://bugs.chromium.org/p/chromium/issues/detail?id=471801
//

;(function() {
  // Only run in iframes, the same as Metastream webviews
  if (window.self === window.top) return

  const mainWorldScript = function() {
    document.getElementById('metastreaminitscript').remove()

    const INIT_TIMEOUT = 5e3
    const isFirefox = navigator.userAgent.toLowerCase().includes('firefox')

    //=========================================================================
    // document.createElement proxy
    //=========================================================================

    window.__metastreamMediaElements = new Set()

    // Proxy document.createElement to trap media elements created in-memory
    const origCreateElement = document.createElement
    const proxyCreateElement = function() {
      const element = origCreateElement.apply(document, arguments)
      if (window.__metastreamMediaElements && element instanceof HTMLMediaElement) {
        window.__metastreamMediaElements.add(element)
      }
      return element
    }
    proxyCreateElement.toString = origCreateElement.toString.bind(origCreateElement)
    document.createElement = proxyCreateElement

    setTimeout(() => {
      if (window.__metastreamMediaElements) {
        window.__metastreamMediaElements.clear()
        window.__metastreamMediaElements = undefined
      }
    }, INIT_TIMEOUT)

    //=========================================================================
    // navigator.mediaSession proxy (Firefox)
    //=========================================================================

    if (isFirefox) {
      // stub out MediaSession API until Firefox supports this natively
      if (!navigator.mediaSession) {
        const noop = () => {}
        const mediaSessionStub = {
          __installedByMetastreamRemote__: true,
          setActionHandler: noop
        }
        Object.defineProperty(window.navigator, 'mediaSession', {
          value: mediaSessionStub,
          enumerable: false,
          writable: true
        })

        function MediaMetadata(metadata) {
          Object.assign(this, metadata)
        }
        window.MediaMetadata = MediaMetadata
      }

      const { mediaSession } = navigator

      // Capture action handlers for player.js proxy
      mediaSession._handlers = {}

      const _setActionHandler = mediaSession.setActionHandler
      mediaSession.setActionHandler = function(name, handler) {
        mediaSession._handlers[name] = handler
        _setActionHandler.apply(mediaSession, arguments)
      }
    }

    //=========================================================================
    // document.domain fix (Firefox)
    //=========================================================================

    if (isFirefox) {
      const domains = ['twitch.tv', 'crunchyroll.com']

      // Fix for setting document.domain in sandboxed iframe
      try {
        const { domain } = document
        if (domain && domains.some(d => domain.includes(d))) {
          Object.defineProperty(document, 'domain', {
            value: domain,
            writable: true
          })
        }
      } catch (e) {}
    }

    //=========================================================================
    // Inline script embed prevention fix
    //=========================================================================

    const observeScripts = () => {
      const scriptSnippets = [
        { code: 'window.top !== window.self', replacement: 'false' },
        { code: 'self == top', replacement: 'true' },
        { code: 'top.location != window.location', replacement: 'false' }
      ]

      const getAddedScripts = mutationList =>
        mutationList.reduce((scripts, mutation) => {
          if (mutation.type !== 'childList') return scripts
          const inlineScripts = Array.from(mutation.addedNodes).filter(
            node => node instanceof HTMLScriptElement && node.textContent.length > 0
          )
          return inlineScripts.length > 0 ? [...scripts, ...inlineScripts] : scripts
        }, [])

      // Modifies inline scripts to allow embedding content in iframe
      const inlineScriptModifier = mutationsList => {
        const scripts = getAddedScripts(mutationsList)
        for (let script of scripts) {
          for (let snippet of scriptSnippets) {
            if (script.textContent.includes(snippet.code)) {
              script.textContent = script.textContent.split(snippet.code).join(snippet.replacement)
            }
          }
        }
      }

      const observer = new MutationObserver(inlineScriptModifier)
      observer.observe(document.documentElement, { childList: true, subtree: true })

      // Stop watching for changes after we finish loading
      window.addEventListener('load', () => observer.disconnect())
    }

    observeScripts()
  }

  const script = document.createElement('script')
  script.id = 'metastreaminitscript'
  script.textContent = `(${mainWorldScript}());`
  if (document.documentElement) {
    document.documentElement.appendChild(script)
  }
})()
