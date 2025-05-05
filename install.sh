#!/bin/bash

TOOL_NAME="defacer"
SCRIPT_FILE="defacer.py"
REQUIREMENTS_FILE="requirements.txt"

INSTALL_DIR="/usr/local/bin"
TERMUX_BIN="$PREFIX/bin"
VENV_DIR="$HOME/.${TOOL_NAME}_venv"
LOCAL_LAUNCHER="$HOME/.local/bin/$TOOL_NAME"

function ensure_path() {
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo "[*] Adding ~/.local/bin to PATH..."
        SHELL_RC=""
        if [ -n "$ZSH_VERSION" ]; then
            SHELL_RC="$HOME/.zshrc"
        elif [ -n "$BASH_VERSION" ]; then
            SHELL_RC="$HOME/.bashrc"
        else
            SHELL_RC="$HOME/.profile"
        fi

        if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$SHELL_RC" 2>/dev/null; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
            echo "[✓] PATH updated in $SHELL_RC. Restart your terminal or run: source $SHELL_RC"
        fi
    fi
}

function install_tool() {
    echo "[*] Installing $TOOL_NAME..."

    if command -v termux-info >/dev/null 2>&1; then
        echo "[*] Detected Termux."
        pkg update -y && pkg install python -y
        pip install --upgrade pip
        pip install -r "$REQUIREMENTS_FILE"

        cp "$SCRIPT_FILE" "$TERMUX_BIN/$TOOL_NAME"
        chmod +x "$TERMUX_BIN/$TOOL_NAME"
        echo "[✓] Installed in Termux. Run with: $TOOL_NAME"
    else
        echo "[*] Detected Linux."
        sudo apt update
        sudo apt install python3 python3-venv python3-pip -y

        echo "[*] Creating virtual environment..."
        python3 -m venv "$VENV_DIR"
        source "$VENV_DIR/bin/activate"

        echo "[*] Installing Python packages..."
        pip install --upgrade pip
        pip install -r "$REQUIREMENTS_FILE"

        echo "[*] Creating launcher script..."
        mkdir -p "$(dirname "$LOCAL_LAUNCHER")"
        cat > "$LOCAL_LAUNCHER" <<EOF
#!/bin/bash
source "$VENV_DIR/bin/activate"
python "$PWD/$SCRIPT_FILE" "\$@"
EOF
        chmod +x "$LOCAL_LAUNCHER"

        ensure_path

        # Try to create global symlink
        if [ -w "$INSTALL_DIR" ]; then
            sudo ln -sf "$LOCAL_LAUNCHER" "$INSTALL_DIR/$TOOL_NAME"
            echo "[✓] Installed globally. Run with: $TOOL_NAME"
        else
            echo "[✓] Installed locally at: $LOCAL_LAUNCHER"
            echo "[*] ~/.local/bin added to PATH if missing."
        fi
    fi
}

function uninstall_tool() {
    echo "[*] Uninstalling $TOOL_NAME..."

    [ -f "$TERMUX_BIN/$TOOL_NAME" ] && rm -f "$TERMUX_BIN/$TOOL_NAME" && echo "[✓] Removed from Termux"
    [ -f "$LOCAL_LAUNCHER" ] && rm -f "$LOCAL_LAUNCHER" && echo "[✓] Removed local launcher"
    [ -f "$INSTALL_DIR/$TOOL_NAME" ] && sudo rm -f "$INSTALL_DIR/$TOOL_NAME" && echo "[✓] Removed global symlink"
    [ -d "$VENV_DIR" ] && rm -rf "$VENV_DIR" && echo "[✓] Removed virtual environment"

    echo "[✓] Uninstallation complete."
}

function menu() {
    clear
    echo "=============================="
    echo "      Defacer Installer"
    echo "=============================="
    echo "[1] Install"
    echo "[2] Uninstall"
    echo "[3] Exit"
    echo "------------------------------"
    read -rp "[?] Choose: " choice
    case "$choice" in
        1) install_tool ;;
        2) uninstall_tool ;;
        3) echo "Goodbye!" && exit 0 ;;
        *) echo "[!] Invalid choice." && sleep 1 && menu ;;
    esac
}

menu
