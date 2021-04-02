'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "404.html": "0a27a4163254fc8fce870c8cc3a3f94f",
"assets/AssetManifest.json": "9c3507615d2bca1881d196267c07e08b",
"assets/assets/gifs/book.gif": "dcf165a275f6388bb8ba7142712a8705",
"assets/assets/images/adventurer/attack1.png": "09c256f619a8d91c4008891d2a68109c",
"assets/assets/images/adventurer/attack3.png": "06a34ec001cb964aa9e2ea77ba6a5e27",
"assets/assets/images/adventurer/idle.png": "7675e82511cda1cb7b859329c1589389",
"assets/assets/images/adventurer/run.png": "1f4716747058edfcdf29bd93abc92361",
"assets/assets/images/parallax/Layer_0000_9.png": "fd8b2b0c50ff57eeff1902cb47ee7fd0",
"assets/assets/images/parallax/Layer_0001_8.png": "90ee0807b702fc7f1cdaf1fbaa4d0a89",
"assets/assets/images/parallax/Layer_0002_7.png": "9331a814041ac81dbe157ba159514310",
"assets/assets/images/parallax/Layer_0003_6.png": "04069ed05a64a0bc0aa305714e3af650",
"assets/assets/images/parallax/Layer_0004_Lights.png": "99a8b5f1f6456de207976bedbf48c030",
"assets/assets/images/parallax/Layer_0005_5.png": "384e084485596ee8c5ce693c3f08fd66",
"assets/assets/images/parallax/Layer_0006_4.png": "0b9e850d96ac26fafb11e817d5bebf05",
"assets/assets/images/parallax/Layer_0007_Lights.png": "49c89c5d3e8bc9ecf6207c0d4be52e62",
"assets/assets/images/parallax/Layer_0008_3.png": "69a670bb02e74102d9175324a9fd5590",
"assets/assets/images/parallax/Layer_0009_2.png": "d0ad2d0ddb2bf38afe49ff6339bba5cc",
"assets/assets/images/parallax/Layer_0010_1.png": "014d56092a181a51e9ee1850dbb7a15b",
"assets/assets/items/Armor%25201.png": "2a327aaa12db9304122f85be32396fe1",
"assets/assets/items/Armor%25202.png": "10abd9a4c1416f73ef75894d20be5842",
"assets/assets/items/Armor%25203.png": "0d67b880d35fa9362a818ebf0d9fee6a",
"assets/assets/items/Armor%25204.png": "ca693ab5b11294d4bfcd6a001bceff53",
"assets/assets/items/Axe%25201.png": "3607582de92ca165d93c88ddcbaf553d",
"assets/assets/items/Axe%25202.png": "75cb8930a42d550faadc456b644e8314",
"assets/assets/items/Axe%25203.png": "ff5b6740ff4b1b01b44a8248d9d773db",
"assets/assets/items/Axe%25204.png": "33cccfb672007827c7016172d78f6eb9",
"assets/assets/items/Axe%25205.png": "aae7aa77e326e490287491248ac3d37c",
"assets/assets/items/Axe%25206.png": "1c4cc6065361a869ddbf4263fa6ce5bd",
"assets/assets/items/Axe%25207.png": "2407f5efc95e5f31138872c04a966583",
"assets/assets/items/Axe%25208.png": "9b3501c7cf9741cefb659762ddb8adce",
"assets/assets/items/blacksmith.jpg": "49a7cbfff3da0a03b8bbf8c7d57478c1",
"assets/assets/items/Potion%25201.png": "47f00f1bf7516159213bcc8be7e9394c",
"assets/assets/items/Potion%25202.png": "b9360115fb5f2322c2e1337503cad443",
"assets/assets/items/Potion%25203.png": "13c9d4850af3ca1695a8ae6da28f1920",
"assets/assets/items/Potion%25204.png": "a0c0fb883f89907d47cb5b27628f966f",
"assets/assets/items/Shield%25201.png": "2b2a15a11d863f270eeb1302b9f91695",
"assets/assets/items/Shield%25202.png": "a503d0d24b23c1ee4671b2e729352e80",
"assets/assets/items/Shield%25203.png": "aacc5d47e71533bb419451355ccdb2e3",
"assets/assets/items/Shield%25204.png": "e6a5e2f6790054756c1ed195c5f8a840",
"assets/assets/items/Shield%25205.png": "1c3c6758b1f898d149ea88b3883dd5bf",
"assets/assets/items/Sword%25201.png": "8a8116de6c37b8d721ef0ade1ecaaae6",
"assets/assets/items/Sword%25202.png": "5bfb726c31f01bfec21196342f6befd8",
"assets/assets/items/Sword%25203.png": "0ca27e4e8257a58f63cb38f5a84d1b05",
"assets/assets/items/Sword%25204.png": "a0db9e0e2f868640795a4afb7bdc4e29",
"assets/assets/items/Sword%25205.png": "6d1ecd94298556e3e6adab632c89ceba",
"assets/assets/items/Sword%25206.png": "fc9b575249edfd8e87741f47cba56110",
"assets/assets/items/Sword%25207.png": "c83f29065ecb43c1a5ffcbbadc05cd37",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "620f639cc16f2ad6807517fa6013ff88",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "aa6ab0a434b08943a191139ddbca3826",
"/": "aa6ab0a434b08943a191139ddbca3826",
"main.dart.js": "a24a21582c0da8c1d163413d73dea977",
"manifest.json": "fd41429ff0a30c1948b8688aba2d6db0",
"version.json": "9129e598bdeacddd5305eb149b5a4aeb"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
