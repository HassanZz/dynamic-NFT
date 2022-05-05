from brownie import network , accounts, config, NFT


LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["development", "ganache-local"]
STATUS_MAPPING = {0: "WIN", 1: "LOSE"}


def get_account():
    if (network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS):
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])

def get_status(status_number):
    return STATUS_MAPPING[status_number]