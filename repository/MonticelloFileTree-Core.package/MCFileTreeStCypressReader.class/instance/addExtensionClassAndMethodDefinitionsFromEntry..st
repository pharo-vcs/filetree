utilities
addExtensionClassAndMethodDefinitionsFromEntry: classEntry
  | classDirectory classPropertiesDict methodPropertiesDict entries |
  classDirectory := self fileUtils directoryFromEntry: classEntry.
  ((entries := classDirectory entries)
    detect: [ :entry | self isPropertyFile: entry ]
    ifNone: [  ])
    ifNotNil: [ :propertyEntry | 
      propertyEntry
        readStreamDo: [ :fileStream | 
          classPropertiesDict := MCFileTreeJsonParser
            parseStream: fileStream ] ].
  methodPropertiesDict := Dictionary new.
  (entries detect: [ :entry | self isMethodPropertyFile: entry ] ifNone: [  ])
    ifNotNil: [ :propertyEntry | 
      propertyEntry
        readStreamDo: [ :fileStream | 
          "Issue 33: https://github.com/dalehenrich/filetree/issues/33"
          methodPropertiesDict := MCFileTreeJsonParser parseStream: fileStream ] ].
  self
    addMethodDefinitionsForClass: (classPropertiesDict at: 'name')
    methodProperties: methodPropertiesDict
    in: entries
    extensionMethod: true
