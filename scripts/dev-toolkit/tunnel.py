"""
Universal Local Tunnel Utility
Exposes local servers (APIs, Web Apps) to a public HTTPS URL.
Usage:
    python tunnel.py <port> [--subdomain <my-subdomain>]
Example:
    python tunnel.py 8000
    python tunnel.py 5173
"""

import sys
import shutil
import subprocess
import argparse

def run_tunnel(port: int, subdomain: str = None):
    lt_path = shutil.which("lt") or shutil.which("lt.cmd")
    cloudflared_path = shutil.which("cloudflared")

    if cloudflared_path:
        print(f"[*] Starting Cloudflare Tunnel on port {port}...")
        cmd = [cloudflared_path, "tunnel", "--url", f"http://localhost:{port}"]
    elif lt_path:
        print(f"[*] Starting Localtunnel on port {port}...")
        cmd = [lt_path, "--port", str(port)]
        if subdomain:
            cmd.extend(["--subdomain", subdomain])
    else:
        print(f"[*] Starting Localtunnel via npx on port {port}...")
        cmd = ["npx", "--yes", "localtunnel", "--port", str(port)]
        if subdomain:
            cmd.extend(["--subdomain", subdomain])

    try:
        subprocess.run(cmd, shell=True)
    except KeyboardInterrupt:
        print("\nTunnel closed.")

def main():
    parser = argparse.ArgumentParser(description="Expose local port to public internet")
    parser.add_argument("port", type=int, help="Local port to expose (e.g. 8000, 3000, 5173)")
    parser.add_argument("--subdomain", type=str, default=None, help="Custom subdomain if available")
    args = parser.parse_args()

    run_tunnel(args.port, args.subdomain)

if __name__ == "__main__":
    main()
