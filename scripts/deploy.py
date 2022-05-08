from brownie import NFT, NFT2
from scripts.helpful_scripts import get_account

def deploy_contract2():
    account = get_account()
    nft = NFT2.deploy({"from": account})
    tx = nft.mint()
    tx.wait(1)

def deploy_contract1():
    account = get_account()
    nft = NFT.deploy('chicagoBulls', "CB",{"from": account})
    for i in range (2):
        tx = nft.mint()
        tx.wait(1)


def main():
    deploy_contract2()