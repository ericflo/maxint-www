# maxint-www

The static Maxint company page. It has no runtime data, JavaScript, secrets, or
external dependencies.

Build and inspect it locally:

```sh
docker build -t maxint-www .
docker run --rm -p 8080:8080 maxint-www
curl --fail http://127.0.0.1:8080/health
```

The Kubernetes deployment lives in the private `epsilon` repository. This
repository owns only the site and its image, so obsolete cluster manifests do
not become a second source of truth.
