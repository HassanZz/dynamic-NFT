from brownie import NFT
from scripts.helpful_scripts import get_account

def deploy_contract():
    account = get_account()
    nft = NFT.deploy('chicagoBulls', "CB",{"from": account})
    tx = nft.mint()
    tx.wait(1)

def main():
    deploy_contract()