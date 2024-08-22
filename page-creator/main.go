package creator

import (
	"context"
	"errors"
	"fmt"
	"os"
	"time"

	"github.com/jomei/notionapi"
)

func Process() (notionapi.ObjectID, error) {
	client := notionapi.NewClient(notionapi.Token(os.Getenv("NOTION_API_KEY")))

	parent := notionapi.Parent{
		Type:   notionapi.ParentTypePageID,
		PageID: notionapi.PageID(os.Getenv("PAGE_ID")),
	}

	properties := notionapi.Properties{
		"title": notionapi.TitleProperty{
			Title: []notionapi.RichText{
				{
					Text: &notionapi.Text{
						Content: fmt.Sprintf("📒 %s", time.Now().Format("02/01/2006")),
					},
				},
			},
		},
	}

	page, err := client.Page.Create(context.Background(), &notionapi.PageCreateRequest{
		Parent:     parent,
		Properties: properties,
	})

	if err != nil {
		return notionapi.ObjectID(0), errors.New("failed to create page")
	}

	return page.ID, nil
}
