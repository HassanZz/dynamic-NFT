from brownie import NFT
from scripts.helpful_scripts import get_account

def deploy_contract():
    account = get_account()
    NFT.deploy({"from": account})




def main():
    deploy_contract()