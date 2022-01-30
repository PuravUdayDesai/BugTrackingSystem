import 'package:bug_bounty/models/Ticket.dart';
import 'package:bug_bounty/models/User.dart';
import 'package:flutter/material.dart';

class Constants {
  List<User> users = [];
  List<Ticket> tickets = [];

  List<User> getUserInfo() {
    users.add(User(
        userId: 10,
        userName: 'Aakash',
        userEmailId: 'aakash@gmail.com',
        userContactNumber: '9876543210',
        userCountry: 'India',
        role: 'Senior Developer'));

    users.add(User(
        userId: 7,
        userName: 'John',
        userEmailId: 'john@gmail.com',
        userContactNumber: '8790654321',
        userCountry: 'USA',
        role: 'Tester'));

    users.add(User(
        userId: 5,
        userName: 'Purav',
        userEmailId: 'purav@gmail.com',
        userContactNumber: '9800043210',
        userCountry: 'Australia',
        role: 'Project Manager'));

    return users;
  }

  List<Ticket> getTickets() {
    tickets.add(Ticket(
        ticketId: 1,
        title: 'Long loading time',
        desc: 'Taking too much time loading images of bills',
        status: 'Resolved',
        priority: 'Normal',
        statusColor: Colors.orange.value));
    tickets.add(Ticket(
        ticketId: 2,
        title: 'Unable to login through admin',
        desc: 'Login failed when tried with admin page',
        status: 'Assigned',
        priority: 'Very High',
        statusColor: Colors.red.value));
    tickets.add(Ticket(
        ticketId: 3,
        title: 'Need QR code in Bills',
        desc: 'In place of barcode need QR code',
        status: 'Created',
        priority: 'Low',
        statusColor: Colors.yellow.value));
    return tickets;
  }
}
