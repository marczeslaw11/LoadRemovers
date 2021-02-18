state("gof_f")
{
    string20 map : 0x530020;
    bool isLoading: 0x51F368;
}

split
{
    return (old.map != "FrontEnd_EndOfLevel" && current.map == "FrontEnd_EndOfLevel");
}

start 
{
    return (old.map == "FrontEnd_CharacterSe" && current.map == "lvl_001_CampsiteWood");
}

isLoading
{
    return current.isLoading;
}
