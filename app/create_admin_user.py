#!/usr/bin/env python3
"""
This script creates django-wiki admin user

"""
from django.contrib.auth import get_user_model

import argparse

__author__ = "Slavik Svyrydiuk"
__email__ = "slavik@svyrydiuk.eu"


def main():
    parser = argparse.ArgumentParser(
        description='Create admin user'
    )

    parser.add_argument(
        '--username',
        dest='username',
        type=str,
        help='Username',
    )
    parser.add_argument(
        '--password',
        dest='password',
        type=str,
        help='password',
    )

    parser.add_argument(
        '--email',
        dest='email',
        type=str,
        help='email',
    )
    parser.add_argument(
        '--verbose',
        help='Enable verbose mode',
        default=False,
        action="store_true",
    )

    args = parser.parse_args()

    username = args.username
    password = args.password
    email = args.email

    User = get_user_model()
    User.objects.create_superuser(
        username=username,
        password=password,
        email=email,
    )


if __name__ == '__main__':
    main()
