pragma solidity ^0.5.0;

/*
l,;;,;;;,,;;,,;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,;;,,,;,,;;,,,,,,,,,,,,,,,,;,,,,,,;;,,,,,,,,;,,;;,,;,,,,,,,;;,,;;,,;,,''l
;................                                                        .''.........................................................................c
;................  ..''.   ....      ... ..                        ..     ''......',......................................'..'.......................c
;................  ;dkxc.  ',,;,'',. .';,;;.                      .,,.    ',......:l,.....................................;'';..............,,.......c
;................   .'..                                                  ',.........................................................................c
;....................................................................................................................................................c
;                ........................................................                                                                            :
,                                  ..           ..                                                                            ...                    ;
,     .....          ....        .,..;,       .,'','.                                                                       .:;;;;.       .,,,'.     ;
,     .....          ....        ',..'.       '::::;.                                                                       .',;,'.       .'''.      ;
,                                 ....         .....                                                                                                 ;
;              .                    .                                                                                                                :
;                                                                                                                                                    ;
;                                                                                                                                                    ;
;                                        .ldd;        'odo' 'odd;                     .:ddl.                                                         ;
;                                ...     ,KMMx. .     lWMWl ,O00c        ...          .o00x'     ...                                                 ;
;           'dOOc .oOOk, 'xOl.,okOkkOx:. ,KMMKxxOOd;  lWMWl ..... .dOOxdk0K0Oo.       ...... .:xOOOOOd;                                              ;
;            oWM0,cNWMMd.xMK:cXMNd;:OMWd.;KMM0:'dWMNl lWMWl :NMMd '0MMKc,dWMMWl       .kMMK,.xWMXc.oNMNo                                             ;
;            .kMWO0NO0MKkXNl.kMMNkddk00x';KMMx. ;XMMk.cWMWl :NMMd ,0MMk. :NMMWo       .kMMK,,KMMk. ,KWMO.                                            ;
;             ;KMWMO'cNMMMk..dWMXc..:xxc.;KMMk. cNMWd.cWMWl :NMMd '0MMk. :NMMWo .;::' .kMMK,.OMM0, :XMWx.                                            ;
;              lNWNl .kWWK;  .o0NKkOXXk, ,KN0OkkXNKo. cNWNc ;XWWo '0WWx. :XWWNl ,0WWd..xWW0, 'xKN0kKNKd.                                             ;
;               .'.   .''.     .',;,'.    .'..',,'.   .'''. .'''.  .''.  .''''.  .''.  .''.    .',,,'.                                               ;
;                                                                                                                                                    ;
;                                                                                                                      .,:;'                         ;
;                         .'.                                                           .''.                           .;cc,.                        ;
;             .          .:ol,.                                                        .c:cl'                         'lloooo:.                      ;
;           .:cc.   .';cldxdddolc;'.                                                   .,,,,.                     .,;coxxdxkkko;'                    ;
;           .,:,.   ,oxkxlcloclkkxl'                                                 .';:,,cc:;.                 .oxxxoldoddloxxx:.                  ;
;          .;;.      .:oc,'''''cl;.                                                 :kOOdc:dO00d.               .oOOkxddxllxooxOOx:                  ;
;           ':.     .o0k;..,,..;kOc.                                               .d0O00xdO000k,               :kOOxxxxxllxxxxkOkl.                 ;
;            ''...':dOKd...,,. .d0x;                                               'kxoO0xxOKkxOc               .cxxdxxxxllxxxxxxl'                  ;
;            '::okO000Xd..,..,..d0Od,                                              :OxkOOkkO0klxk'                .,oOkOOddOOkko,                    ;
;            'ldxkkllOXd';, .;,'x0ddd'                                            .d000OO00OOOolOc                 .dOO00kO0OOOc                     ;
;            .;:;,. ,0Xk:,. .',ckk:;lc.                 .',:llc'                  'ldOOk000Ok0o.,;.                ;KNXNXXXXXXNO'                    ;
;             ..    cXXk:'. .''l0Kd.                     .'ckKk:                  ...oOkOkkOkOl  ..                :XNXNKodXNXN0,                    ;
;             ..   .dXKx;'...''o0XKc                      .;ccl:.                    ,k00doOOOc                    cXNNXo..dNNNK,                    ;
;             ..   'OX0d,,..,.,dOKNx.                   ,:.    ,l,                   .x0KxlO0Oc                    lXNNx.  .xNNK;                    ;
;             ..   cKKOo,,'',':xk0X0;                 'oo.      :xl.                 .dKKxckK0l                   .kNN0,    ,0NNx.                   ;
;              .  .xX0kl;;;;,,oxxOKXl                .oc..     .,co'                  c0Kk:xXKo.                  :KNNd.     oNNXl                   ;
;              .  'xOkxxxxdxdoxkxkKXk.               .'  ........,,.                  :OKOcdKKx.                 .dNNK;      .kNNk.                  ;
;              ..  ..:xkkxxxxxxkkxl,.                    .'::::,.                     ,kK0ooKKk'                 .kNNd.       ;KWXc                  ;
;              ..   .oOOxccccllx0k,                      .:'''.;'                     .ckd,;xOd'                .;xOd.        .oXKo.                 ;
d;;;;;;;;;;;;;;c:;;cx00Kx:;:::ckK0d;;;;;;;;;;;;;;;;;;;;;:dkl;;:xxc;;;;;;;;;;;;;;;;;;;;;oOd::xOOd:;;;;;;;;;;;;;;cdOOd:;;;;;;;;;;oO0kko:;;;;;;;;;;;;;;;d
*/

import "./ERC721Tradable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @title LootPlaces
 * LootPlaces - a contract for my non-fungible Metaverse Loot Places as building blocks for the metaverse.
 */
contract LootPlaces is ERC721Tradable {

    constructor(address _proxyRegistryAddress)
        public ERC721Tradable("Metaverse Loot Places", "LOTPL", _proxyRegistryAddress)
    {
    }

}
