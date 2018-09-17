FROM mysql:5.7
COPY . ./
CMD ["./src/testing.sh"]