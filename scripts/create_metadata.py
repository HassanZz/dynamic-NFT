from brownie import NFT, network
from get_metadata.rikeby.metadata import metadata_template
from pathlib import Path
from scripts.helpful_scripts import get_status
import requests
# import json
# import os

def main():
    dynamicNFT = NFT[-1]
    number_of_NFT = dynamicNFT.tokenId()
    for token_id in range(1):
        status = get_status(token_id)
        metadata_dir = (f"./get_metadata/{network.show_active()}/{token_id}-{status}.json")
        NFT_metadata = metadata_template
        if Path(metadata_dir).exists() :
            print ('metadatafile exists!')
        else:
            NFT_metadata['name'] = status
            NFT_metadata['description'] = 'dynamic nft!'
            image_path = f"./img/{status}.jpg"
            image_uri = upload_to_ipfs(image_path)
            NFT_metadata['image'] = image_uri
            print (NFT_metadata)

def upload_to_ipfs(filepath):
    with Path(filepath).open('rb') as fp :
        image_binary = fp.read()
        ipfs_url = 'http://127.0.0.1:5001'
        endpoint = '/api/v0/add'
        response = requests.post(ipfs_url + endpoint, files = {"file" : image_binary})
        ipfs_hash = response.json()["Hash"]
        filename = filepath.split('/')[-1:][0]
        image_uri = f"https://ipfs.io/ipfs/{ipfs_hash}?filename={filename}"
        print (image_uri)
        return image_uri