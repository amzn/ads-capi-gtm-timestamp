# Amazon CAPI Timestamp — Server-Side Variable Template for Google Tag Manager

This Google Tag Manager server-side variable template converts epoch timestamps to ISO-8601 format (`YYYY-MM-DDThh:mm:ssZ`), as required by the Amazon Ads Events API. This variable is a companion to the [Amazon Events API Tag](https://github.com/amzn/ads-events-api-gtm-tag).

## Configuration

After importing the template, create a new variable using the Amazon CAPI Timestamp template:

- **Epoch milliseconds (optional)**: Provide a specific epoch timestamp in milliseconds. If left blank, the current server time is used automatically.

## Usage

1. Create a new variable in your GTM server container using the **Amazon CAPI Timestamp** template.
2. Leave **Epoch milliseconds** blank for real-time events, or populate it with a GTM variable containing the original event timestamp for delayed/offline event ingestion.
3. Save the variable.
4. In the **Amazon Events API Tag**, select this variable in the **Event Time** field.

The variable handles:

- Reading the provided epoch value (or falling back to the current server time)
- Converting the epoch milliseconds to ISO-8601 format (`YYYY-MM-DDThh:mm:ssZ`)

## Support

For issues or questions, please open an issue in this repository.

## Security

All timestamps are processed entirely within your GTM server container. No data is sent to external services by this variable.

See [CONTRIBUTING](CONTRIBUTING.md) for more information.

## License

Apache 2.0 — see [LICENSE](LICENSE)
