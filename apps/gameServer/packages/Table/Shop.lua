
local Struct = {
    id = 0,
    rid = 0,
    uniques = "", --已经购买过的id列表
}

local Define = {
    id = "int NOT NULL AUTO_INCREMENT PRIMARY KEY",
    rid = "int NOT NULL",
    uniques = "varchar(4096)  NOT NULL",
}

local Indexes = {
    "UNIQUE KEY `unid` (`rid`)  USING HASH",
}

return {
    Struct = Struct,
    Define = Define,
    Indexes = Indexes,
    Name = "Shop",
}
