package main

import (
	"context"
	"errors"
	"fmt"

	creator "github.com/Jackthomsonn/notion-page-creator/page-creator"
)

type CreatePageEvent struct {
}

func HandleRequest(ctx context.Context, event *CreatePageEvent) (*string, error) {
	if event == nil {
		return nil, fmt.Errorf("received nil event")
	}

	created_page, err := creator.Process()
	if err != nil {
		return nil, errors.New("error creating page")
	}

	message := fmt.Sprintf("page created: %s", created_page)

	return &message, nil

}

func main() {
	HandleRequest(context.TODO(), &CreatePageEvent{})
}
