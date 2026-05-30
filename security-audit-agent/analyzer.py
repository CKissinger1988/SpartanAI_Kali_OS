# SecurityAuditAgent: Defensive PCAP Analyzer
# This agent analyzes network traffic to flag insecure protocol usage.
# It does NOT extract or store credentials, only detects vulnerable patterns.

import sys
from scapy.all import rdpcap, TCP, IP

def analyze_insecure_traffic(pcap_file):
    print(f"[SECURITY-AUDIT] Starting analysis of {pcap_file}...")
    packets = rdpcap(pcap_file)
    findings = []
    
    # Example: Flag insecure protocols on common ports
    # This is a defensive pattern matcher, not a credential extractor.
    for pkt in packets:
        if pkt.haslayer(TCP) and pkt.haslayer(IP):
            if pkt[TCP].dport in [21, 23, 80]:
                findings.append(f"Insecure protocol detected on port {pkt[TCP].dport}")
                
    return list(set(findings))

if __name__ == "__main__":
    pcap_file = sys.argv[1]
    results = analyze_insecure_traffic(pcap_file)
    for finding in results:
        print(f"[!] {finding}")
