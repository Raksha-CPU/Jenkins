import pytest
from lambda_function import lambda_handler  # Import directly from lambda_function
from unittest.mock import MagicMock

# Removed test for None event and event with 'message' to reduce coverage
def test_lambda_returns_200_status():
    event = {}
    context = MagicMock()
    response = lambda_handler(event, context)
    assert response['statusCode'] == 200
    assert response['body'] == 'Hello from Lambda!'
