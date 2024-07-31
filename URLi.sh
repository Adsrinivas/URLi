#!/bin/bash

# Define the color code for red
RED='\033[0;31m'
GRN='\033[0;32m'
# Reset color
NC='\033[0m'
# Print each line with echo in red
echo -e "${RED}				 _   _ ____  _     _ ${NC}"
echo -e "${RED}				| | | |  _ \| |   (_)${NC}"
echo -e "${RED}				| | | | |_) | |   | |${NC}"
echo -e "${RED}				| |_| |  _ <| |___| |${NC}"
echo -e "${RED}				 \___/|_| \_\_____|_|${NC}"
echo -e "${GRN}	   		  Made by ADSrinivas, Satyam & Ketan${NC}"


# Step 0: Create a folder named "URLi_Output"
output_dir="URLi_Output/$(date +"%Y%m%d_%H%M%S")"
mkdir -p "$output_dir"

# Step 1: Ask for the subdomains.txt file or file path
read -p "Enter the path to the subdomains.txt file: " subdomains_path

# Ensure the file exists
if [ ! -f "$subdomains_path" ]; then
    echo "File not found: $subdomains_path"
    exit 1
fi

# Step 2: Run the Live domains Extraction command
echo "Checking for live domains"
while IFS= read -r domain; do
    if curl -s -o /dev/null -w "%{http_code}" "https://$domain" -m 5 | grep -q "^[23]"; then
        echo "https://$domain" >> "$output_dir/live_domains.txt"
        echo "Found live domain: https://$domain"
    elif curl -s -o /dev/null -w "%{http_code}" "http://$domain" -m 5 | grep -q "^[23]"; then
        echo "http://$domain" >> "$output_dir/live_domains.txt"
        echo "Found live domain: http://$domain"
    else
        echo "Domain not responding: $domain"
    fi
done < "$subdomains_path"

# Check if live_domains.txt exists and is not empty
if [ -s "$output_dir/live_domains.txt" ]; then
    echo "Live domains found:"
    cat "$output_dir/live_domains.txt"
    echo "Total live domains: $(wc -l < "$output_dir/live_domains.txt")"
else
    echo "No live domains found."
fi


# Step 3: Run the Waybackurls command
echo "Running Waybackurls"
cat "$output_dir/live_domains.txt" | waybackurls > "$output_dir/waybackurls.txt"

# Step 4: Run the hakrawler command
echo "Running hakrawler"
cat "$output_dir/live_domains.txt" | hakrawler -d 5 > "$output_dir/hakrawler_live.txt"

# Step 5: Run the gospider command
echo "Running gospider"
gospider -S "$output_dir/live_domains.txt" -o "$output_dir/gospider_output" -t 50 -c 3 --depth 5
cat "$output_dir/gospider_output"/* > "$output_dir/gospider_urls.txt"
rm -r "$output_dir/gospider_output"

# Step 6: Extract domain names from live_domains.txt
domains=$(cat "$output_dir/live_domains.txt" | sed -E 's~https?://([^/]+).*~\1~' | sort -u)

# Step 7 & 8: Run the Wayback Machine and Alienvault commands for each domain
for domain in $domains; do
    echo "Fetching Wayback Machine data for $domain"
    curl -s "https://web.archive.org/cdx/search/cdx?url=*.$domain&fl=original&collapse=urlkey" >> "$output_dir/web_archive_$domain.txt"
    echo "Fetching Alienvault data for $domain"
    curl -s "https://otx.alienvault.com/api/v1/indicators/domain/$domain/url_list?limit=100&page=1" >> "$output_dir/otx_alienvault_$domain.txt"
done

# Step 9: Run the command to sort unique URLs and Subdomains extraction from URLi_Output.txt file
echo "Sorting and deduplicating URLs"
cat "$output_dir/"* | sort -u > "$output_dir/URLi_Output.txt"

# Step 10: Run the Paramspider command
echo "Running Paramspider"
paramspider -l "$output_dir/live_domains.txt"
cat results/* | tee -a paramspider_output.txt
mv paramspider_output.txt $output_dir/paramspider_output.txt
rm -r results

echo "Script execution completed. All output files are saved in $output_dir."
echo "These are the main file in an output folder: paramspider_output.txt && URLi_Output.txt"
