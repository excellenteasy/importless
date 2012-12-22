# importless [![Build Status](https://travis-ci.org/excellenteasy/importless.png?branch=master)](https://travis-ci.org/excellenteasy/importless)

Get .less/.css files from directory without @imports for automatic stylesheet dependency tracking.

## Getting Started
Install the module with: `npm install importless`

```javascript
var importless = require('importless'),
    files = importless.detectDependencies();
```

If you have any questions, or want to talk, feel free to join our [chatroom](http://www.hipchat.com/gHCQ1nzUb).

## License
Copyright (c) 2012 David Pfahler
Licensed under the MIT license.