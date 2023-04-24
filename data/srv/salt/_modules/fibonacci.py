import logging

logger = logging.getLogger(__name__)

__func_alias__ = {
    "list_": "list",
}

def _fibonacci(n) -> list:
    result = [1, 1]
    for i in range(n - 2):
        result.append(result[i] + result[i + 1])
    
    return result

def list_(start=1, end=10, length=True):
    """_summary_

    Args:
        start (int, optional): _description_. Defaults to 1.
        end (int, optional): _description_. Defaults to 10.
        length (bool, optional): _description_. Defaults to True.
    """
    logger.info(f'Counting fibonacci from {start} to {end} elements')

    result = {
        'start': start,
        'end': end,
        'fibonacci': _fibonacci(end)[start - 1:]
    }

    if length:
        result['length'] = len(result['fibonacci'])
    return result

if __name__ == '__main__':
    import json
    print(json.dumps(list_(), indent=2))