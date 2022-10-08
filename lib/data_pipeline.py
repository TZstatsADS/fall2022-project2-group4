import yaml
import json
import sodapy
import os
from typing import Dict, Iterable, Any
import pandas as pd
import csv
from copy import deepcopy

_CONFIG: Dict = None
_CLIENT: sodapy.Socrata = None


def read_config(filepath: str = None) -> Dict:
    """
    Read the configuration file for the current project.
    If the configuration file is not present, a ConfigurationFileNotFound
    will be raised.

    Parameters:
    ----------
            filepath : `str`
                    Location of the YAML configuration file.
    """
    # ADD _CONFIG to the scope of the function
    global _CONFIG

    # Default path for the configuration file
    if not filepath:
        filepath = "./lib/config.yaml"

    # Read the configuration file
    with open(filepath, 'r') as f:
        _CONFIG = yaml.safe_load(f)


def download_datasets(**kwargs) -> None:
    """
    Download the datasets specified in the 
    config.yaml file.

    Parameters:
    -----------
        options : `Dict`
            Options to pass to the SodaPY client.
    """

    _ensure_config_loaded()
    _ensure_client_started()

    datasets = _CONFIG["datasets"]

    # Initialize empty dictionaries for the dataset option
    # if not specified

    for name, values in datasets.items():

        identifier: str = values["identifier"]
        content_type: str = values["content_type"]

        options: str = _parse_options(
            values["options"],
            **kwargs
        )
        name = name.replace(" ", "_").lower()

        filename: str = f"{name}.{content_type}"
        filepath: str = f"./data/{filename}"

        if not _file_is_writable(filepath):
            print(f"{filename} download cancelled.")
            continue

        # Get the raw data from NYC Open Data
        raw_data = _download_dataset(
            identifier,
            content_type,
            name,
            options
        )

        # Save the file to the data directory
        _write_file(filepath, raw_data, content_type)


def _parse_options(options, **kwargs) -> Dict:
    new_options = deepcopy(options)
    for name, value in kwargs.items():
        new_value = deepcopy(value)

        # Check if the value is iterable
        if isinstance(new_value, list):
            new_value = ",".join(new_value)

        new_options[name] = new_value

    for name, value in new_options.items():
        new_value = deepcopy(value)

        # Check if the value is iterable
        if isinstance(new_value, list):
            new_value = ",".join(new_value)

        new_options[name] = new_value

    return new_options


def _download_dataset(
        identifier: str,
        content_type: str,
        name: str,
        options: Dict) -> Any:
    """
    Download the specified dataset using the
    SodaPY Client.

    Parameters:
    -----------
        identifier : `str`
            Socrata API identifier.
        content_type : `str`
            File type to download the dataset.
        name : `str`
            Name of the dataset
        options : `str`
            Options to pass to the SodaPY client.
    """

    print(f"Downloading {name}.{content_type}. This may take a while...")

    # Get the method for downloading the data
    get_data = _CLIENT.get_all
    if "limit" in options:
        get_data = _CLIENT.get

    # Start download from client
    raw_data = get_data(
        dataset_identifier=identifier,
        content_type=content_type,
        **options
    )

    print(f"{name}.{content_type} downloaded successfully!")

    return raw_data


def _write_file(filepath: str, data: Iterable, content_type: str) -> None:
    """
    Write the downloaded to the specified file and extension
    """
    content_type = content_type.lower()

    with open(filepath, "w", newline='', encoding="utf-8") as f:
        if content_type == "csv":
            writer = csv.writer(f, dialect='excel')
            writer.writerows(data)

        elif content_type == "json":
            json.dump(data, f)


def _file_is_writable(filepath: str) -> bool:
    """
    Check if the downloaded file
    is writable.

    Parameters:
    -----------
            filepath : `str`
                    Path to the file to check.
    """
    if os.path.exists(filepath):
        response = input(f"The file already exists. "
                        "Do you want to overwrite the file? (yes/no)")
        response = response.strip().lower()
        if response == "no":
            print("File not overwritten!")
            return False
        elif response == "":
            return False

    return True


def _ensure_config_loaded() -> None:
    """
    Read the configuration fil from the default location
    if the configuration file has not been loaded.
    """
    if not isinstance(_CONFIG, dict):
        read_config()


def _ensure_client_started() -> None:
    """
    Ensures that the SodaPY client
    has been initliazed.
    """
    global _CLIENT

    # Get the configuration for the client
    client_config = _CONFIG["socrata"]
    domain = client_config["domain"]
    app_token = client_config["app_token"]
    username = client_config["username"]
    password = client_config["password"]
    timeout = client_config["timeout"]

    # Initialize a client session
    _CLIENT = sodapy.Socrata(
        domain=domain,
        app_token=app_token,
        username=username,
        password=password,
        timeout=timeout
    )
