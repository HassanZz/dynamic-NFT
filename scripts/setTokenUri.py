from brownie import network, NFT
from scripts.helpful_scripts import OPENSEA_URL, get_status, get_account

metadata_dic = {
    "WIN": "https://ipfs.io/ipfs/QmdXbYooopjiuYphC5GfXTzKn79gmvZy5mt2QHjchiPo7Y?filename=WIN.png",
    "LOSE": "https://ipfs.io/ipfs/QmZ619tipjs3SVh6nM5U9bK2ScuWZ7zkT8iQt2LzT3JrZE?filename=LOSE.png",
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
    print(
        f"Awesome! You can view your NFT at {OPENSEA_URL.format(nft_contract.address, token_id)}"
    )
    print("Please wait up to 20 minutes, and hit the refresh metadata button")
