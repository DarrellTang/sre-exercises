package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"sort"
)

func main() {
  //Check if a filename was passed in as a param
	if len(os.Args) < 2 {
		fmt.Println("Please enter a filename. i.e. ./ips sample.log")
		os.Exit(1)
	}

  //Read file contents
	filename := os.Args[1]
	file, err := os.Open(filename)
	if err != nil {
		fmt.Printf("Error reading filename of: %v", filename)
		fmt.Println(err)
		os.Exit(1)
	}
	defer file.Close()

  //Create regex matching object
	//https://gobyexample.com/regular-expressions
	ipregexstring := `[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}`
	regex, _ := regexp.Compile(ipregexstring)

  //Scan each line in log file and count occurrences in a map
	//https://stackoverflow.com/questions/8757389/reading-a-file-line-by-line-in-go
	scanner := bufio.NewScanner(file)

	var counts = make(map[string]int, 0)
	for scanner.Scan() {
		ip := regex.FindString(scanner.Text())
    counts[ip]++
	}

	//https://stackoverflow.com/questions/70151032/how-to-sort-map-by-value-and-if-value-equals-then-by-key-in-go
	// Never had to do this before so needed to look it up. Harder than I expected.
  //Convert map to a slice of structs and sort that with built in sort.Slice()
	countslice := mapToSlice(counts)
	sort.Slice(countslice, func(i, j int) bool {
		// 1. value is different - sort by value (in reverse order)
		if countslice[i].qty != countslice[j].qty {
			return countslice[i].qty > countslice[j].qty
		}
		// 2. only when value is the same - sort by key
		return countslice[i].ip < countslice[j].ip
	})

  //Loop through and print number of occurrences and ip address
	for _, count := range countslice {
		fmt.Printf("%v %v\n", count.qty, count.ip)
	}

}

//Converts a map to a slice of structs
func mapToSlice(m map[string]int) []Count {
	counts := make([]Count, len(m))
	i := 0
	for k, v := range m {
		counts[i].ip = k
		counts[i].qty = v
		i++
	}
	return counts
}

//Struct to hold information for sorting by values
type Count struct {
	ip  string
	qty int
}
