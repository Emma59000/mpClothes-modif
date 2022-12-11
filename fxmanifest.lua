fx_version 'adamant'

game 'gta5'

files {
  "*.meta",
  "*.json",
}

client_scripts {
  'config.lua',
  'common.lua',
  'client/*.lua',
}

server_scripts {
  'config.lua',
  'common.lua',
  'server/*.lua',
}

exports {
  'skipValue',
  'valueInContinue',
  'continueToValue',
  'isCustomId',
  'toCustomId',
  'fromCustomId',
  'toCustomSkin',
  'fromCustomSkin',
  'isSkipped',
}

server_exports {
  'skipValue',
  'valueInContinue',
  'continueToValue',
  'isCustomId',
  'toCustomId',
  'fromCustomId',
  'toCustomSkin',
  'fromCustomSkin',
  'isSkipped',
}



data_file "SHOP_PED_APPAREL_META_FILE" "mp_f_freemode_01_clothes_shop.meta"
data_file "SHOP_PED_APPAREL_META_FILE" "mp_m_freemode_01_clothes_shop.meta"