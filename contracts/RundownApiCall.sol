// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract sportContract is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  address private oracle;
  bytes32 private jobId;
  uint256 private fee;
  bytes32 public data;
  mapping(bytes32 => bytes[]) public requestIdGames;
  struct GameResolve {
    bytes32 gameId;
    uint8 homeScore;
    uint8 awayScore;
    uint8 statusId;
}
    GameResolve public game;

    constructor() {
    setPublicChainlinkToken();
    oracle = 0xfF07C97631Ff3bAb5e5e5660Cdf47AdEd8D4d4Fd;
    jobId = "9de17351dfa5439d83f5c2f3707ffa9e";
    fee = 0.1 * 10 ** 18; // (Varies by network and job)
  }

    function requestData(
        string memory _market,
        uint256 _sportId,
        uint256 _date
        ) public returns (bytes32 requestId)  {
      Chainlink.Request memory req = buildChainlinkRequest(jobId, address(this), this.fulfillGames.selector);

        req.addUint("date", _date);
        req.add("market", _market);
        req.addUint("sportId", _sportId);
      return sendChainlinkRequestTo(oracle, req, fee);
  }
        function fulfillGames(bytes32 _requestId, bytes[] memory _games) public recordChainlinkFulfillment(_requestId) {
        requestIdGames[_requestId] = _games;
    }
    
    function getGamesResolved(bytes32 _requestId, uint256 _idx) external returns (GameResolve memory) {
        game = abi.decode(requestIdGames[_requestId][_idx], (GameResolve));
        return game;
    }
  }
