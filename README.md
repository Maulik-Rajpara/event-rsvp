# Event RSVP App

## Overview

The Event RSVP App allows users to view upcoming events, RSVP to them, and receive reminders about the events. It also includes features like offline syncing and conflict resolution for RSVP data.

## Features

- **Real-time Attendee Count**: View the number of attendees for each event in real-time.
- **Offline RSVP Syncing**: RSVP to events while offline; the app will sync your responses when back online.
- **Local Notifications**: Receive reminders for upcoming events.
- **User Authentication**: Secure login and registration using Firebase Auth.
- **Efficient Pagination**: Load events efficiently with pagination.

## Technologies Used

- **Flutter**: UI framework.
- **Firebase**: For real-time data and user authentication.
- **Hive**: Local database for offline storage.
- **flutter_local_notifications**: For scheduling notifications.
- **Provider**: State management.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/event_rsvp_app.git
cd event_rsvp_app
