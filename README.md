## URLi
This script automates the installation of various security tools and performs a series of actions to identify and analyze live domains. The script checks for the existence of required tools, installs them if necessary, and executes several steps to gather and process URLs.

### Prerequisites

- A Unix-based operating system (e.g., Linux)
- `sudo` privileges
- Bash Language and Git:
   ```bash
   sudo apt install bash git
   ```

### Tools Installed

- `golang-go`
- `git`
- `waybackurls`
- `hakrawler`
- `gospider`
- `httpx`
- `ParamSpider`

### Script Description

The script performs the following steps:

1. Update and Upgrade System:
   Updates and upgrades the system packages.

2. Install Dependencies:
   Installs Go and Git.

3. Create Go Workspace:
   Sets up a Go workspace if it doesn't exist.

4. Install Tools:
   Installs `waybackurls`, `hakrawler`, `gospider`, `httpx`, and `ParamSpider` if they are not already installed.

5. Move Go Binaries:
   Moves Go binaries to `/usr/bin` for easy access.

6. Print Welcome Message:
   Displays a welcome message with the authors' names.

7. Create Output Directory:
   Creates an output directory named `URLi_Output` with a timestamp.

8. Read Subdomains File:
   Prompts the user to input the path to the `subdomains.txt` file.

9. Check for Live Domains:
   Checks the live status of domains listed in the `subdomains.txt` file and saves live domains to `live_domains.txt`.

10. Run Waybackurls:
    Runs `waybackurls` on live domains and saves the output.

11. Run Hakrawler:
    Runs `hakrawler` on live domains and saves the output.

12. Run Gospider:
    Runs `gospider` on live domains and saves the output.

13. Fetch Additional Data:
    Fetches data from the Wayback Machine and Alienvault for each domain.

14. Sort and Deduplicate URLs:
    Sorts and deduplicates URLs from the gathered data.

15. Run Paramspider:
    Runs `ParamSpider` on live domains and saves the output.

### Usage

1. Clone the repository or download the script:
   ```bash
   git clone https://github.com/Adsrinivas/URLi.git
   ```
2. Make the script executable:
   ```bash
   chmod +x install.sh URli.sh 
   ```
3. Run the install.sh:
   ```bash
   ./install.sh
   ```
4. Run the script:
   ```bash
   ./URLi.sh
   ```
5. Follow the prompts to provide the path to your `subdomains.txt` file.

### Output

The script generates an output directory named `URLi_Output` with a timestamp. The main output files are:

- `live_domains.txt`
- `waybackurls.txt`
- `hakrawler_live.txt`
- `gospider_urls.txt`
- `URLi_Output.txt`
- `paramspider_output.txt`

### Authors

- ADSrinivas
- Satyam
- Ketan

### License

This project is licensed under the MIT License.

### Acknowledgements

Special thanks to the creators of the tools used in this script.

---

Feel free to modify the script and README to suit your needs. If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.
