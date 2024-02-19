# Gleitzeit Management Tool
<img src="./public/favicon.ico" title="Ai generated I ain't no designer" alt="GZM logo" width="200" height="200">

## Overview

The Gleitzeit Management Tool is a web-based application designed to facilitate the tracking and management of flexible working hours (Gleitzeit). Built using Vue.js.

## Installation

To install the Gleitzeit Managment Tool run this command:

```bash
docker run -d -p 8080:80 --name gzm voidlesity/gzm
```

This command runs the container in detached mode, maps port 8080 on your host to port 80 on the container, and names the container `gzm`.

## Usage

After installing you can go to [http://localhost:8080](http://localhost:8080) and use the application

## Development

### Prerequisites

Before you can run the Gleitzeit Management Tool, ensure you have the following installed:

- [Docker](https://www.docker.com/)
- [Nodejs](https://nodejs.org/en)

### Installation

#### Step 1: Clone the Repository

First, clone the repository to your local machine. Open a terminal and run:
```bash
git clone https://github.com/voidlesity/gzm.git
cd gzm
```

#### Step 2: Starting the application

To start the application run:
```bash
npm run serve
```

Now when you add your changes they will automatically update in the browser