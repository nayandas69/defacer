# DEFACER - Web Defacement Tool

> A powerful and user-friendly web defacement tool written in Python by [Nayan Das](https://github.com/nayandas69)

![DEFACER](https://raw.githubusercontent.com/nayandas69/defacer/main/img/DEMO.png)

## What is DEFACER?

**DEFACER** is a Python-based web defacement tool that allows you to upload a deface page (e.g., `index.html`, `index.php`) to multiple target websites via HTTP PUT method. It supports both command-line arguments and interactive menus.

> [!IMPORTANT]
> This tool is made for **educational** and **security research** purposes only. Unauthorized defacement of websites is illegal.

## Features

* [x] Command-line and interactive modes  
* [x] Works on Linux distros and Termux  
* [x] Upload `.html`, `.php`, etc., using HTTP PUT  
* [x] Fast and colorful output with result status  
* [x] Auto-handles missing `http://` in URLs  
* [x] Easy to install and run globally

## Requirements

* [x] Python 3.x  
* [x] `requests` module (auto-installed via `install.sh`)

> [!NOTE]
> Python 2 is **not supported**. You must have Python 3 installed.

## Installation & Setup

### Linux

```bash
git clone https://github.com/nayandas69/defacer.git
cd defacer
pip3 install -r requirements.txt
python3 defacer.py --script index.html --targets targets.txt
```

> \[!TIP]
> You can also run the `install.sh` script to install dependencies and make the tool globally available.
> If you encounter any issues, please check the requirements and ensure all dependencies are installed.
```bash
chmod +x install.sh defacer.py
./install.sh
```

Follow the prompt:

* Type `install` to install dependencies and make the tool globally available
* After that, just run `defacer` from anywhere

### Termux (Android)

```bash
pkg update && pkg upgrade
pkg install git python -y
git clone https://github.com/nayandas69/defacer.git
cd defacer
chmod +x install.sh defacer.py
./install.sh
```

> \[!TIP]
> If Termux asks for storage permission, run `termux-setup-storage` and allow access.

## Usage

### Command-Line Mode

```bash
python3 defacer.py --script index.html --targets targets.txt
```

* `--script`: Path to your deface HTML/PHP file
* `--targets`: A `.txt` file with target URLs (one per line)

### Interactive Menu Mode

Just run:

```bash
defacer
```

You'll get a colorful menu where you can:

* Enter your deface file path
* Enter your targets list
* View upload results live

## targets.txt Format

Your `targets.txt` should contain **one site per line**. Example:

```
http://example.com
testphp.vulnweb.com
https://zero.webappsecurity.com
```

> \[!WARNING]
> This tool uses HTTP PUT. Only use on **legally allowed targets** such as test environments or with permission.

## Disclaimer

> \[!WARNING]
> This tool is provided for **ethical hacking**, **security research**, and **educational purposes**.
> You are **solely responsible** for how you use it.
> Any misuse may lead to **legal consequences**.

## ❤️ Support & Contributions

* [ ] Add FTP/SFTP support
* [ ] Add auto-vulnerability checker
* [x] Multi-threaded upload (coming soon)

Pull requests and ideas are welcome!

## Author

[GitHub](https://github.com/nayandas69)
Reach out for collaboration or feedback!
