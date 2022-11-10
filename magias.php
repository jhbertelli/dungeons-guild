<?php

    $magics = json_decode(file_get_contents("app/resources/json/spells_sorted.json"));

    print_r(json_encode($magics));
