
getLakeName = function(){
  lakeName = data.frame(lakeid = c('TR', 'CR', 'BM', 'SP', 'AL', 'TB', 'CB', 'ME', 'MO', 'FI', 'WI'),
                        waterbody_name = c('Trout Lake',
                                           'Crystal Lake',
                                           'Big Muskellunge Lake',
                                           'Sparkling Lake',
                                           'Allequash Lake',
                                           'Trout Bog',
                                           'Crystal Bog',
                                           'Lake Mendota',
                                           'Lake Monona',
                                           'Fish Lake',
                                           'Lake Wingra'))
  return(lakeName)
}
