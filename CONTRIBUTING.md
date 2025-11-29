# Contributing Guidelines

Thank you for considering contributing to the Deepfake Detection System!

## How to Contribute

### Reporting Bugs
- Use GitHub Issues
- Include detailed description
- Provide steps to reproduce
- Include system information

### Suggesting Features
- Open an issue with [Feature Request] tag
- Describe the feature and use case
- Explain why it would be useful

### Code Contributions

1. **Fork the repository**
2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow existing code style
   - Add comments for complex logic
   - Update documentation if needed

4. **Test your changes**
   ```bash
   # Backend tests
   cd backend
   python -m pytest

   # Frontend tests
   npm test
   ```

5. **Commit your changes**
   ```bash
   git commit -m "Add: brief description of changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Describe your changes
   - Reference any related issues
   - Wait for review

## Code Style

### Python (Backend)
- Follow PEP 8
- Use type hints
- Add docstrings for functions
- Keep functions focused and small

### TypeScript (Frontend)
- Use TypeScript strict mode
- Follow React best practices
- Use functional components
- Add prop types

## Testing

- Write tests for new features
- Ensure existing tests pass
- Aim for >80% code coverage

## Documentation

- Update README.md if needed
- Add comments for complex code
- Update API documentation
- Include examples

## Questions?

Open an issue or reach out to maintainers.

Thank you for contributing! 🎉
