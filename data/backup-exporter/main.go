package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
	// Create new Prometheus counters for weekly and monthly backups
	weeklyBackups := prometheus.NewCounter(prometheus.CounterOpts{
		Name: "weekly_backups_total",
		Help: "Number of weekly backups",
	})
	monthlyBackups := prometheus.NewCounter(prometheus.CounterOpts{
		Name: "monthly_backups_total",
		Help: "Number of monthly backups",
	})

	// Register the metrics with the Prometheus collector
	prometheus.MustRegister(weeklyBackups, monthlyBackups)

	// Start an HTTP server to expose the metrics on port 9950
	http.Handle("/metrics", promhttp.Handler())
	go func() {
		if err := http.ListenAndServe(":9950", nil); err != nil {
			panic(err)
		}
	}()

	// Increment the weekly or monthly backups based on the current time when a curl request is made
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		switch r.URL.Path {
		case "/weeklyBackupsInc":
			weeklyBackups.Inc()
		case "/monthlyBackupsInc":
			monthlyBackups.Inc()
		default:
			http.Redirect(w, r, "/metrics", http.StatusSeeOther)
			return
		}
		fmt.Fprintf(w, "Backup recorded at %s\n", time.Now().Format("2006-01-02 15:04:05"))
	})

	// Wait indefinitely
	select {}
}
