build:
	hugo --minify

clean:
	rm -Rf public/ resources/_gen/

server:
	hugo server --bind=0.0.0.0 --baseUrl=http://0.0.0.0 --port=1313 -s .