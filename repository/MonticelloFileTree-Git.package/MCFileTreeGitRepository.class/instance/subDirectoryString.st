accessing
subDirectoryString
	"relative path of the repository inside the git repository."

	^ subDirectoryString
		ifNil: [ subDirectoryString := String
				streamContents: [ :s | 
					(directory asAbsolute relativeTo: self gitTopDirectory) segments
						do: [ :e | 
							s
								nextPutAll: e;
								nextPut: $/ ] ] ]