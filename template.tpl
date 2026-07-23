___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Amazon CAPI Timestamp",
  "description": "Timestamp converter from epoch to ISO-8601. Please ensure values are in epochMilliseconds.",
  "categories": ["ADVERTISING", "ANALYTICS", "CONVERSIONS"],
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "epochMs",
    "displayName": "Epoch milliseconds (optional)",
    "simpleValueType": true,
    "help": "Optional. Provide a specific epoch timestamp in milliseconds. If blank, the current server time is used."
  }
]


___SANDBOXED_JS_FOR_SERVER___

// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

const getTimestampMillis = require('getTimestampMillis');
const Math = require('Math');
const logToConsole = require('logToConsole');
function epochToISO(epochMilliseconds) {
    let epochSeconds = Math.floor(epochMilliseconds / 1000);
    
    const SECONDS_PER_MINUTE = 60;
    const MINUTES_PER_HOUR = 60;
    const HOURS_PER_DAY = 24;
    const DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    function isLeapYear(year) {
        return year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0);
    }

    function addZero(number) {
        if (number < 10) {
            return "0" + number;
        }
        return number.toString();
    }

    let year = 1970;
    while (true) {
        const daysInYear = isLeapYear(year) ? 366 : 365;
        const secondsInYear = daysInYear * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE;
        if (epochSeconds < secondsInYear) break;
        epochSeconds = epochSeconds - secondsInYear;
        year++;
    }

    let month = 0;
    while (month < 12) {
        let daysInMonth = DAYS_IN_MONTH[month];
        if (month === 1 && isLeapYear(year)) daysInMonth++;
        const secondsInMonth = daysInMonth * HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE;
        if (epochSeconds < secondsInMonth) break;
        epochSeconds = epochSeconds - secondsInMonth;
        month++;
    }
    month++;

    const secondsInDay = HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE;
    const days = Math.floor(epochSeconds / secondsInDay) + 1;
    epochSeconds = epochSeconds - (Math.floor(epochSeconds / secondsInDay) * secondsInDay);

    const secondsInHour = MINUTES_PER_HOUR * SECONDS_PER_MINUTE;
    const hours = Math.floor(epochSeconds / secondsInHour);
    epochSeconds = epochSeconds - (Math.floor(epochSeconds / secondsInHour) * secondsInHour);
    const hours_offset = hours;

    const minutes = Math.floor(epochSeconds / SECONDS_PER_MINUTE);
    const seconds = epochSeconds - (minutes * SECONDS_PER_MINUTE);

    return year + '-' + 
           addZero(month) + '-' + 
           addZero(days) + 'T' + 
           addZero(hours_offset) + ':' + 
           addZero(minutes) + ':' + 
           addZero(seconds) + 'Z';
}

// Variables must return a value.
var makeInteger = require('makeInteger');
return epochToISO(data.epochMs ? makeInteger(data.epochMs) : getTimestampMillis());


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Returns correct ISO-8601 string for known epoch
  code: |-
    mock('getTimestampMillis', function() { return 1735689600000; });
    var result = runCode();
    assertThat(result).isEqualTo('2025-01-01T00:00:00Z');

- name: Returns correct ISO-8601 string for provided epochMs
  code: |-
    mock('getTimestampMillis', function() { return 0; });
    var result = runCode({ epochMs: '1735689600000' });
    assertThat(result).isEqualTo('2025-01-01T00:00:00Z');


___NOTES___

Created in May 2026 by Amazon Ad Tech Solutions.

## Version History
- v1.0.0 (May 2026): Initial release


