import (
	"fmt"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	//TELETOKEN BOT
	TeleToken = os.Getenv("TELE_TOKEN")
)

var kbotCMD = &cobra.Command{
	Use:   "kbot",
	Short: "Short description",
	Long:  "Long description",

	Run: func(cmd *cobra.Command, args []string) {

		fmt.Printf("kbot %s started", appVersion)
		kbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please check TELE_TOKEN env variable. %s", err)
			return
		}

		kbot.Handle(telebot.OnText, func(m telebot.Context) error {
			log.Pring(m.Message().Payload, m.Text())

			return err
		})

		kbot.Start()
	},
}