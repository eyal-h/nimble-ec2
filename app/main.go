package main

import (
	"github.com/gin-gonic/gin"
	"log"
)

func main() {
	RunAPI()
}

func RunAPI() {
	// Swagger 2.0 Meta Information
	server := gin.Default()
	apiRoutes := server.Group("")
	apiRoutes.GET("", Hello)

	err := server.Run("25565")
	if err != nil {
		log.Println("%V", err)
	}
}

func Hello(c *gin.Context) {
	c.JSON(200, "hello_V3!")
}
