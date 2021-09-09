pragma solidity ^0.5.0;

library Strings {
  // via https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_0.5.sol
  function cat(string memory _a, string memory _b) internal pure returns (string memory) {
      bytes memory _ba = bytes(_a);
      bytes memory _bb = bytes(_b);
      string memory ab = new string(_ba.length + _bb.length);
      bytes memory bab = bytes(ab);
      uint k = 0;
      for (uint i = 0; i < _ba.length; i++) bab[k++] = _ba[i];
      for (uint i = 0; i < _bb.length; i++) bab[k++] = _bb[i];
      return string(bab);
    }

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    function contains(string memory haystack, string memory needle) internal pure returns (bool) {
        bytes memory needleBytes = bytes (needle);
        bytes memory haystackBytes = bytes (haystack);

        bool found = false;
        for (uint i = 0; i < haystackBytes.length - needleBytes.length; i++) {
            bool flag = true;
            for (uint j = 0; j < needleBytes.length; j++)
                if (haystackBytes [i + j] != needleBytes [j]) {
                    flag = false;
                    break;
                }
            if (flag) {
                found = true;
                break;
            }
        }
        
        return found;
    }
}