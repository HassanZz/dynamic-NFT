from brownie import network, NFT
from scripts.helpful_scripts import OPENSEA_URL, get_status, get_account

metadata_dic = {
    "WIN": "https://ipfs.io/ipfs/QmSJZEUkFzv2G6FX3QqeHAemcjYeLgin5UNi6bPG9DPCst?filename=0-WIN.json",
    "LOSE": "https://ipfs.io/ipfs/Qmd1zsHWSEVw3U4Bj4DAB4LcQ2QqsSVbKp2R2sniozDEMp?filename=1-LOSE.json",
}

def main():
    dynamicNFT = NFT[-1]
    number_of_NFT = dynamicNFT.tokenId()
    for token_id in range(number_of_NFT):
        status = get_status(token_id)
        if not dynamicNFT.tokenURI(token_id).startswith("https://"):
            set_tokenURI(token_id, dynamicNFT, metadata_dic[status])


def set_tokenURI(token_id, nft_contract, tokenURI):
    account = get_account()
    tx = nft_contract.setTokenURI(token_id, tokenURI, {"from": account})
    tx.wait(1)
    print(f"Awesome! You can view your NFT at {OPENSEA_URL.format(nft_contract.address, token_id)}")
    print("Please wait up to 20 minutes, and hit the refresh metadata button")
