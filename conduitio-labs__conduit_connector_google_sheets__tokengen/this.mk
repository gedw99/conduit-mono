### bin

# -code: string. 
#         generate token from auth code, if already available, and don't start the redirect server
THIS_CODE=??

# -credentials string. 
#         path to the credentials.json, default: ./credentials.json (default "/Users/apple/workspace/go/src/github.com/gedw99/kanka-cloudflare/modules/conduit/conduitio-labs__conduit-connector-google-sheets__tokengen/credentials.json")
# Path to credentials file which can be downloaded from Google Cloud Platform(in .json format) to authorise the user.
THIS_CREDENTIALS=./credentials.json

# -host string
#         url host to start redirect URI listener at, default: 127.0.0.1 (default "127.0.0.1")
THIS_HOST=127.0.0.0

#   -out string
#         file to store the generated tokens, default: ./token_<ts>.json (default "/Users/apple/workspace/go/src/github.com/gedw99/kanka-cloudflare/modules/conduit/conduitio-labs__conduit-connector-google-sheets__tokengen/token_1721538688.json")
THIS_OUT=./token_gedw99.json

#  -port string
#        url port to start redirect URI listener at, default: 3000 (default "3000")
THIS_PORT=3000

this-run-start:
	# If you dont have a code
	$(BASE_RUN) -credentials $(THIS_CREDENTIALS) -host $(THIS_HOST) -out $(THIS_OUT) -port $(THIS_PORT)

this-run-start-with-cred:
	# Alternatively, if you already have the auth code present, then you can run:
	$(BASE_RUN) -code $(THIS_CODE) -credentials $(THIS_CREDENTIALS) -host $(THIS_HOST) -out $(THIS_OUT) -port $(THIS_PORT)




