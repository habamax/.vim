********************************************************************************
                                 CURL with Vim
********************************************************************************


.. code::

  # call for some API
  --url https://some-/rest/2.0/attributeTypes
  --header "Authorization: Basic YWRtaW46cGFzc3dvcmQ="

.. code::

  --url https://localhost:8889/portal/check_dp
  --user username:password
  --silent
  --show-error
  --header "Content-Type: application/json"
  --data
  {
      "email": "some-email@gmail.com",
      "country_code":  "AU",
      "city": "Melbourne"
  }
