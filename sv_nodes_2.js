// Return a list of Bitcoin SV nodes.
//
// Usage:
//
//     node ./nodes.js nodes.json
//
// where "nodes.js" is the name of this file, and "nodes.json" was
// created from the following command.
//
//     curl https://api.blockchair.com/bitcoin-sv/nodes > nodes.json
//
// Author : Scott Barr
// Date   : 17 Nov 2018

const fs = require('fs');

// get the filename from the args (assumes you give the filename as the arg)
const filename = process.argv[2];

// read the file
const content = fs.readFileSync(filename);

// parse the JSON
const nodes = JSON.parse(content).data.nodes;

// get the addressess
const addresses = Object.keys(nodes);

addresses.forEach(function(address) {
  // get the node by address
  const n = nodes[address];

  // show the address if it is a Bitcoin SV node
  if (n.version.startsWith('/Bitcoin SV:1.0.')) {
    console.log(`addnode=${address}`);
  }
});
