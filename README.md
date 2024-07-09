<h1 align="center" style="color: orange;">Monero Garden 🌿</h1>

<p align="center"> “Tell me and I forget, teach me and I may remember, involve me and I learn.” — Benjamin Franklin </p>

<p align="center"><a href="https://monero.garden"><img src="https://img.shields.io/badge/Visit%20the%20garden-ff774d?style=for-the-badge&logo=leaflet&logoColor=green"></a></p>

---

### Run the garden locally

Clone the garden's repo and get into the cloned directory:

```bash
git clone https://github.com/monerogarden/web.git
cd web
```

On debian 12, open a terminal window and enter the following command
to install [nvm](https://github.com/nvm-sh/nvm):

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

Close the terminal window, and open a new terminal window.  Change
directory back to the `web` directory.  Now using `nvm` install
compatible versions of nodejs and npm:

```bash
nvm install 18.14
```

Now enter the following command to compile the content:

```bash
npm i
npx quartz build --serve
```

The monero garden is now available locally.  Open a web browser and
visit `http://127.0.0.1:8080/` to view it.

---

<p align="center"><sub>Monero Garden is built with <a href="https://quartz.jzhao.xyz/">quartz</a></sub></p>
