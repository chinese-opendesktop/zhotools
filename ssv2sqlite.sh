#!/bin/bash
_DATABASE="$1"

rm -f $_DATABASE.sqlite

echo -e "`

    case $_DATABASE in zhocompose)
      echo "CREATE TABLE compose ("
      echo "   comp_code VARCHAR(7),"
      echo "   sqrword CHAR(4),"
      echo "   strokes INT,"
      echo "   regular CHAR(1),"
      echo "   PRIMARY KEY (sqrword, regular) ) ;"
      echo "BEGIN TRANSACTION;"

      Split=$(grep -n -m 1 "#####" zhocompose.ssv | cut -d ":" -f 1)

      head -n $(( $Split - 1 )) zhocompose.ssv | \
      sed -r -e "s/^ +//" -e "s/ +$//" -e "s/ +/ /g" | \
      sed -e "s/ /', '/1" -e "s/ /', /2"\
          -e "s/^/INSERT INTO compose VALUES ('/" \
          -e "s/$/, 'F');/"

      tail -n +$(( $Split + 1 )) zhocompose.ssv | \
      sed -r -e "s/^ +//" -e "s/ +$//" -e "s/ +/ /g"  | \
      sed -e "s/ /', '/1" -e "s/ /', /2"\
          -e "s/^/INSERT INTO compose VALUES ('/" \
          -e "s/$/, 'T');/"

      echo "COMMIT TRANSACTION;"

    ;; zhoortho)
      echo "CREATE TABLE ortho ("
      echo "   mistake CHAR(16) NOT NULL,"
      echo "   ortho CHAR(16),"
      echo "   PRIMARY KEY (mistake) ) ;"
      echo "BEGIN TRANSACTION;"

      sed -r -e "s/^ +//" -e "s/ +$//" -e "s/ +/ /g" zhoortho.ssv | \
      sed -e "s/ /', '/" \
          -e "s/^/INSERT INTO ortho VALUES ('/" \
          -e "s/$/');/"

      echo "COMMIT TRANSACTION;"

    ;; zhorelate)
      echo "CREATE TABLE relate ("
      echo "   leader CHAR(6) NOT NULL,"
      echo "   fellows VARCHAR(255),"
      echo "   PRIMARY KEY (leader) ) ;"
      echo "BEGIN TRANSACTION;"

      sed -r -e "s/^ +//" -e "s/ +$//" -e "s/ +/ /g" zhorelate.ssv | \
      sed -e "s/ /', '/" \
          -e "s/^/INSERT INTO relate VALUES ('/" \
          -e "s/$/');/"

      echo "COMMIT TRANSACTION;"

    ;; zhotrans)
      echo "CREATE TABLE trans ("
      echo "   bopomofo CHAR(16) NOT NULL,"
      echo "   pinyin VARCHAR(18),"
      echo "   braile VARCHAR(12),"
      echo "   bopomo_keys VARCHAR(4),"
      echo "   pinyin_keys CHAR(7),"
      echo "   braile_keys VARCHAR(3),"
      echo "   PRIMARY KEY (bopomofo) ) ;"
      echo "BEGIN TRANSACTION;"

      sed -r -e "s/^ +//" -e "s/ +$//" -e "s/ +/ /g" zhotrans.ssv | \
      sed -e "s/'/''/g" \
          -e "s/ /', '/1" -e "s/ /', '/2" -e "s/ /', '/3" \
                -e "s/ /', '/4" -e "s/ /', '/5" \
          -e "s/^/INSERT INTO trans VALUES ('/" \
          -e "s/$/');/"

      echo "COMMIT TRANSACTION;"

    ;; zhottp)
      echo "CREATE TABLE txt2pho ("
      echo "   text VARCHAR(80) NOT NULL,"
      echo "   phonetic VARCHAR(255),"
      echo "   PRIMARY KEY (text) ) ;"
      echo "BEGIN TRANSACTION;"

      sed -r -e "s/^ +//" -e "s/ +$//" -e "s/ +/ /g" zhottp.ssv | \
      sed -e "s/ /', '/" \
          -e "s/^/INSERT INTO txt2pho VALUES ('/" \
          -e "s/$/');/"

      echo "COMMIT TRANSACTION;"

      ( LANG="zh_TW.UTF-8"
        _SSV="$(grep "^[^[:blank:]]\{4,\}" zhottp.ssv | cut -d " " -f 1)"
        MixLength=4
        while test "$_SSV" ; do
          MixLength=$(($MixLength+1))
          _SSV=$(echo -e "$_SSV" | grep "^[^[:blank:]]\{$MixLength,\}")
        done
        MixLength=$(($MixLength-1))

        echo "CREATE TABLE mixlength ( mixlength INT ) ;"
        echo "INSERT INTO mixlength VALUES ( $MixLength ) ;"
      )

    esac

    echo ".exit"

`" | sqlite3 $_DATABASE.sqlite

