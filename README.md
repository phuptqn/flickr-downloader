## Getting Started

This script allow you to get photo list and download them from people on Flickr.

### Prerequisites

You need to install the following things to run the script.
* git bash (for Windows users): Instruction [here](https://git-scm.com/downloads)
* jq: Instruction [here](https://stedolan.github.io/jq/download/)
* curl (if it's not already installed): Instruction [here](https://everything.curl.dev/get)

### Installation

1. Get a free API Key at [https://www.flickr.com/services/api/keys/](https://www.flickr.com/services/api/keys/)
2. Clone the repo
   ```sh
   git clone https://github.com/phuptqn/flickr-downloader.git
   ```
3. Update your API in `flickr_downloader.sh`
   ```sh
   API_KEY="YOUR_API_KEY"
   ```

## Usage

```sh
cd flickr-downloader
sh ./flickr_downloader.sh
```

## Contact

phuptqn - phuptqn@gmail.com