# google sheets

https://github.com/conduitio-labs/conduit-connector-google-sheets

has a generic cmd for generating a connection to google !

https://github.com/conduitio-labs/conduit-connector-google-sheets/tree/main/cmd/tokengen

i can reuse this for everything that needs to conenct to google


It is hard coded to google sheets, so just need to make this a config

```go
scopes = []string{
		"https://www.googleapis.com/auth/spreadsheets.readonly",
		"https://www.googleapis.com/auth/spreadsheets",
	}
```




