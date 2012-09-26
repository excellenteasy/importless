# less-detect

Get .less/.css files from directory without @imports for automatic stylesheet dependency tracking.

## Getting Started
Install the module with: `npm install less-detect`

```javascript
var importless = require('importless'),
    files = importless.detectDependencies();
```

## License
Copyright (c) 2012 David Pfahler  
Licensed under the MIT license.