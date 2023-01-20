# Hansel 🍪 (also known as Persona Extension)


# Running Web-Crawling

### Go to web-crawling directory
```
cd web-crawling
```

### Install packages with pip
```
pip install -r requirements.txt
```

### Run api with uvicorn server
```
uvicorn main:app --reload
```

Now your local host is running and waiting for requests from the web extension.

# Building Chrome Extension

### Go to ui directory
```
cd ui
```
### Build extension
```
flutter build web --web-renderer html --csp
```

### Load unpacked extension
1. Go to the `chrome://extensions` URL on Google Chrome
2. Click on the load unpacked button and choose the build directory 
